From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Wed, 25 May 2022 20:43:57 +0530
Subject: [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
In-Reply-To: <20220505184603.1548-1-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
Message-ID: <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello Eric,

On 06/05/22 00:15, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).
>
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (e. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility. In previous posts I have
> outlined the significant performance problems related to offloading
> this activity to userspace.
>
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
>
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory. No involvement
> with userspace needed.
>
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
>
>   - Disable the udev rule for updating kdump on hot un/plug changes.
>     Add the following as the first two lines to the udev rule file
>     /usr/lib/udev/rules.d/98-kexec.rules:

If we can have a sysfs attribute to advertise this feature then userspace
utilities (kexec tool/udev rules) can take action accordingly. In short, 
it will
help us maintain backward compatibility.

kexec tool can use the new sysfs attribute and allocate additional 
buffer space
for elfcorehdr accordingly. Similarly, the checksum-related changes can come
under this check.

Udev rule can use this sysfs file to decide kdump service reload is 
required or not.

Thanks,
Sourabh Jain


