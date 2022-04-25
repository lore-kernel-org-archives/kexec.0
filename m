From: Mohamed Abuelfotoh, Hazem <abuehaze@amazon.com>
Date: Mon, 25 Apr 2022 20:49:40 +0000
Subject: [PATCH] arm64/crashdump-arm64: increase CRASH_MAX_MEMORY_RANGES
 to 32k
In-Reply-To: <CEAC6AFC-4D7A-4F5B-8B32-8E70B2677A97@amazon.com>
References: <20220419172327.11288-1-abuehaze@amazon.com>
 <9DCE6E84-37DB-49D4-B87C-B49963C68621@amazon.com>
 <CEAC6AFC-4D7A-4F5B-8B32-8E70B2677A97@amazon.com>
Message-ID: <E67277A8-534D-4506-96A4-E71AF8CC966D@amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Ping!

?On 19/04/2022, 19:48, "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:

    Adding Simon to the thread.

    Thank you.

    Hazem

    On 19/04/2022, 19:36, "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:

        Hey Team,

        - I am sending this e-mail for more context about the previous submitted patch, we are seeing an issue on aarch64 based EC2 instances where kdump will load failing showing "Number of crash memory ranges excedeed the max limit"  if the amount of memory hotplugged to the instance reach 32 GB while is 32 * 1GB memory blocks as shown below. It looks like we are hitting the CRASH_MAX_MEMORY_RANGES limit which is 32 on aarch64 compared to around 2k before been increased to 32K on x86 as mentioned in https://www.spinics.net/lists/kexec/msg26574.html . so when we hotplug a new memory region there is kexec udev rules configured to reload kdump for updating the elfcorehdr note info for memory bank/cpu changes that  works fine until we hit the CRASH_MAX_MEMORY_RANGES limit then we are seeing kdump load failure as shown below.


        [root at ip-xx-xx-xx-xx ec2-user]# echo 0x0000000b80000000  > /sys/devices/system/memory/probe 
        [root at ip-xx-xx-xx-xx ec2-user]# lsmem 
        RANGE                                 SIZE  STATE REMOVABLE BLOCK
        0x0000000040000000-0x000000007fffffff   1G online       yes     1
        0x0000000400000000-0x00000004bfffffff   3G online       yes 16-18
        0x0000000500000000-0x0000000bbfffffff  27G online       yes 20-46

        Memory block size:         1G
        Total online memory:      31G
        Total offline memory:      0B

        [root at ip-xx-xx-xx-xx ec2-user]# service kdump status 
        Redirecting to /bin/systemctl status kdump.service
        ? kdump.service - Crash recovery kernel arming
           Loaded: loaded (/usr/lib/systemd/system/kdump.service; enabled; vendor preset: enabled)
           Active: active (exited) since Fri 2022-04-15 22:16:34 UTC; 9s ago
          Process: 6185 ExecStop=/usr/bin/kdumpctl stop (code=exited, status=0/SUCCESS)
          Process: 6194 ExecStart=/usr/bin/kdumpctl start (code=exited, status=0/SUCCESS)
         Main PID: 6194 (code=exited, status=0/SUCCESS)

        Apr 15 22:16:33 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: Starting Crash recovery kernel arming...
        Apr 15 22:16:34 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[6194]: kexec: loaded kdump kernel
        Apr 15 22:16:34 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: Started Crash recovery kernel arming.
        Apr 15 22:16:34 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[6194]: Starting kdump: [OK]
        [root at ip-xx-xx-xx-xx ec2-user]# echo 0x0000000bc0000000  > /sys/devices/system/memory/probe 

        [root at ip-xx-xx-xx-xx ec2-user]# lsmem 
        RANGE                                 SIZE  STATE REMOVABLE BLOCK
        0x0000000040000000-0x000000007fffffff   1G online       yes     1
        0x0000000400000000-0x00000004bfffffff   3G online       yes 16-18
        0x0000000500000000-0x0000000bffffffff  28G online       yes 20-47

        Memory block size:         1G
        Total online memory:      32G
        Total offline memory:      0B

        [root at ip-xx-xx-xx-xx ec2-user]# service kdump status 
        Redirecting to /bin/systemctl status kdump.service
        ? kdump.service - Crash recovery kernel arming
           Loaded: loaded (/usr/lib/systemd/system/kdump.service; enabled; vendor preset: enabled)
           Active: failed (Result: exit-code) since Fri 2022-04-15 22:17:14 UTC; 1s ago
          Process: 6362 ExecStop=/usr/bin/kdumpctl stop (code=exited, status=0/SUCCESS)
          Process: 6371 ExecStart=/usr/bin/kdumpctl start (code=exited, status=1/FAILURE)
         Main PID: 6371 (code=exited, status=1/FAILURE)

        Apr 15 22:17:13 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: Starting Crash recovery kernel arming...
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[6371]: Error: Number of crash memory ranges excedeed the max limit
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[6371]: kexec: load failed.
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[6371]: Cannot load /boot/vmlinuz-5.10.102-99.473.amzn2.aarch64
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[6371]: kexec: failed to load kdump kernel
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[6371]: Starting kdump: [FAILED]
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: kdump.service: main process exited, code=exited, status=1/FAILURE
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: Failed to start Crash recovery kernel arming.
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: Unit kdump.service entered failed state.
        Apr 15 22:17:14 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: kdump.service failed.


        - With the proposed patch, I am able to hotplug 256 GB of memory to the EC2 instance and kdump is working appropriately. 

        [root at ip-xx-xx-xx-xx ec2-user]# lsmem 
        RANGE                                  SIZE  STATE REMOVABLE  BLOCK
        0x0000000040000000-0x000000007fffffff    1G online       yes      1
        0x0000000400000000-0x00000004bfffffff    3G online       yes  16-18
        0x0000000500000000-0x000000433fffffff  249G online       yes 20-268

        Memory block size:         1G
        Total online memory:     253G
        Total offline memory:      0B
        [root at ip-172-31-1-51 ec2-user]# service kdump status 
        Redirecting to /bin/systemctl status kdump.service
        ? kdump.service - Crash recovery kernel arming
           Loaded: loaded (/usr/lib/systemd/system/kdump.service; enabled; vendor preset: enabled)
           Active: active (exited) since Sat 2022-04-16 01:10:38 UTC; 32s ago
          Process: 15653 ExecStop=/usr/bin/kdumpctl stop (code=exited, status=0/SUCCESS)
          Process: 15662 ExecStart=/usr/bin/kdumpctl start (code=exited, status=0/SUCCESS)
         Main PID: 15662 (code=exited, status=0/SUCCESS)

        Apr 16 01:10:37 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: Starting Crash recovery kernel arming...
        Apr 16 01:10:38 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[15662]: kexec: loaded kdump kernel
        Apr 16 01:10:38 ip-xx-xx-xx-xx.eu-west-1.compute.internal kdumpctl[15662]: Starting kdump: [OK]
        Apr 16 01:10:38 ip-xx-xx-xx-xx.eu-west-1.compute.internal systemd[1]: Started Crash recovery kernel arming.


        On 19/04/2022, 19:23, "abuehaze14" <abuehaze@amazon.com> wrote:

            On ARM64 based VMs hotplugging more than 31GB of memory will cause
            kdump to fail loading as it's hitting the CRASH_MAX_MEMORY_RANGES
            limit which is currently 32 on ARM64 given that the  memory block size
            is 1GB. This patch is raising CRASH_MAX_MEMORY_RANGES
            to 32K similar to what we have on x86, this should allow
            kdump to work until the VM has 32TB which should be
            enough for a long time.

            Signed-off-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
            ---
             kexec/arch/arm64/crashdump-arm64.h | 2 +-
             1 file changed, 1 insertion(+), 1 deletion(-)

            diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
            index 12f4308..82fa69b 100644
            --- a/kexec/arch/arm64/crashdump-arm64.h
            +++ b/kexec/arch/arm64/crashdump-arm64.h
            @@ -14,7 +14,7 @@

             #include "kexec.h"

            -#define CRASH_MAX_MEMORY_RANGES	32
            +#define CRASH_MAX_MEMORY_RANGES	32768

             /* crash dump kernel support at most two regions, low_region and high region. */
             #define CRASH_MAX_RESERVED_RANGES	2
            -- 
            2.32.0




