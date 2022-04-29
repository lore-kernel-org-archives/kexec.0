From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Fri, 29 Apr 2022 08:08:28 -0500
Subject: [PATCH v3 00/10] x86/sev: KEXEC/KDUMP support for SEV-ES guests
In-Reply-To: <YmuqifsJltdh7rpv@localhost.localdomain>
References: <20220127101044.13803-1-joro@8bytes.org>
 <YmuqifsJltdh7rpv@localhost.localdomain>
Message-ID: <46b27b72-aabf-f37d-7304-29debeefd8ae@amd.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 4/29/22 04:06, Tao Liu wrote:
> On Thu, Jan 27, 2022 at 11:10:34AM +0100, Joerg Roedel wrote:

> 
> Hi Joerg,
> 
> I tried the patch set with 5.17.0-rc1 kernel, and I have a few questions:
> 
> 1) Is it a bug or should qemu-kvm 6.2.0 be patched with specific patch? Because
>     I found it will exit with 0 when I tried to reboot the VM with sev-es enabled.
>     However with only sev enabled, the VM can do reboot with no problem:

Qemu was specifically patched to exit on reboot with SEV-ES guests. Qemu 
performs a reboot by resetting the vCPU state, which can't be done with an 
SEV-ES guest because the vCPU state is encrypted.

> 
> [root at dell-per7525-03 ~]# virsh start TW-SEV-ES --console
> ....
> Fedora Linux 35 (Server Edition)
> Kernel 5.17.0-rc1 on an x86_64 (ttyS0)
> ....
> [root at fedora ~]# reboot
> .....
> [   48.077682] reboot: Restarting system
> [   48.078109] reboot: machine restart
>                         ^^^^^^^^^^^^^^^ guest vm reached restart
> [root at dell-per7525-03 ~]# echo $?
> 0
> ^^^ qemu-kvm exit with 0, no reboot back to normal VM kernel
> [root at dell-per7525-03 ~]#
> 
> 2) With sev-es enabled and the 2 patch sets applied: A) [PATCH v3 00/10] x86/sev:
> KEXEC/KDUMP support for SEV-ES guests, and B) [PATCH v6 0/7] KVM: SVM: Add initial
> GHCB protocol version 2 support. I can enable kdump and have vmcore generated:
> 
> [root at fedora ~]# dmesg|grep -i sev
> [    0.030600] SEV: Hypervisor GHCB protocol version support: min=1 max=2
> [    0.030602] SEV: Using GHCB protocol version 2
> [    0.296144] AMD Memory Encryption Features active: SEV SEV-ES
> [    0.450991] SEV: AP jump table Blob successfully set up
> [root at fedora ~]# kdumpctl status
> kdump: Kdump is operational
> 
> However without the 2 patch sets, I can also enable kdump and have vmcore generated:
> 
> [root at fedora ~]# dmesg|grep -i sev
> [    0.295754] AMD Memory Encryption Features active: SEV SEV-ES
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ patch set A & B
> 	       not applied, so only have this string.
> [root at fedora ~]# echo c > /proc/sysrq-trigger
> ...
> [    2.759403] kdump[549]: saving vmcore-dmesg.txt to /sysroot/var/crash/127.0.0.1-2022-04-18-05:58:50/
> [    2.804355] kdump[555]: saving vmcore-dmesg.txt complete
> [    2.806915] kdump[557]: saving vmcore
>                             ^^^^^^^^^^^^^ vmcore can still be generated
> ...
> [    7.068981] reboot: Restarting system
> [    7.069340] reboot: machine restart
> 
> [root at dell-per7525-03 ~]# echo $?
> 0
> ^^^ same exit issue as question 1.
> 
> I doesn't have a complete technical background of the patch set, but isn't
> it the issue which this patch set is trying to solve? Or I missed something?

The main goal of this patch set is to really to solve the ability to 
perform a kexec. I would expect kdump to work since kdump shuts down all 
but the executing vCPU and performs its operations before "rebooting" 
(which will exit Qemu as I mentioned above). But kexec requires the need 
to restart the APs from within the guest after they have been stopped. 
That requires specific support and actions on the part of the guest kernel 
in how the APs are stopped and restarted.

Thanks,
Tom

> 
> Thanks,
> Tao Liu
>   
>> _______________________________________________
>> Virtualization mailing list
>> Virtualization at lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

