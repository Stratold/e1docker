require "net/http"
require "yaml"

def produce_resources(desc)
    out = <<~ENDSTRING
    resource "aws_instance" "#{desc['name']}" {
        ami = "#{desc['ami']}"
        instance_type = "#{desc['type']}"
        key_name = "${aws_key_pair.#{desc['name']}.key_name}"
        vpc_security_group_ids = [
            "${aws_security_group.default.id}"
        ]
        tags {
            Name = "#{desc['name']}"
        }
        root_block_device {
            volume_type = "gp2"
            volume_size = 8
            delete_on_termination = true
        }
    }
    resource "aws_key_pair" "#{desc['name']}" {
        key_name = "#{desc['name']}"
        public_key = "#{desc['sshkey']}"
    }
    ENDSTRING

    puts out
end

def main()
    c = 0
    while true
        sleep 5
        resp = Net::HTTP.get(URI("http://candidateexercise.s3-website-eu-west-1.amazonaws.com/exercise1.yaml"))
        resphash = YAML.load(resp)
        resphash['machines'].each do |key,value|
            produce_resources value
        end
    end
end

main
