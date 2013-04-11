Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <51658B1A.6090706@wwwdotorg.org>
References: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
 <51658B1A.6090706@wwwdotorg.org>
Date: Thu, 11 Apr 2013 12:46:07 +0800
Message-ID: <CAFNq8R6mRJRygfnYvZgwVWOqsrhrjNUYzyZGU0cVsnE30W_xGg@mail.gmail.com>
Subject: Re: Kexec couldn't reboot capture kernel on pandaboard ES with
 OMAP4460
From: Li Haifeng <omycle@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-omap@vger.kernel.org, pandaboard@googlegroups.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2013/4/10 Stephen Warren <swarren@wwwdotorg.org>:
> On 04/10/2013 03:35 AM, Li Haifeng wrote:
>> Hi, everyone.
>>
>> Recently, I try to run kdump on pandaboard ES with omap4460. After
>> load capture kernel by "kexec -l" and execute "kexec -e", the serial
>> port output "Starting new kernel" and "Bye", then the system hangs up.
>>
>> I have tried the upstream Linux Kernel v3.4 and v3.8. All are with this issue.
>
> This is a shot in the dark. I assume you have SMP enabled. Can you use
> hotplug to remove all CPUs other than CPU0, so that the kexec happens on
> the boot CPU? That is certainly necessary for kexec to work correctly on
> Tegra.

Thanks for your attention.

I do disable SMP feature. And the .config file for v3.8 could be found here:
http://pastehtml.com/view/cylyrfejt.txt

The log and operation could be found here:
http://pastehtml.com/view/cylyfrb3a.txt

Some key setting list below.

bootargs:
rw vram=32M fixrtc mem=1G@0x80000000 root=/dev/mmcblk0p2
console=ttyO2,115200n8 rootwait crashkernel=64M@0x82000000

operation:
/ # ./kexec -l  --append="rw vram=32M fixrtc  root=/dev/mmcblk0p2 console=ttyO2,
115200n8 rootwait" uImage
/ # ./kexec -d -e

The output:
[   57.373687] Starting new kernel
[   57.377044] Bye!

Then system hangs.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
