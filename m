Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wt0u4-0005gZ-N6
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 20:38:20 +0000
Message-ID: <53922686.6010301@zytor.com>
Date: Fri, 06 Jun 2014 13:37:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in kernel
 loading
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140603131203.GA23395@redhat.com>
 <20140605083134.GE3506@darkstar.nay.redhat.com>
 <20140605150159.GA14083@redhat.com>
 <20140606073748.GC3343@darkstar.nay.redhat.com>
In-Reply-To: <20140606073748.GC3343@darkstar.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Fleming, Matt" <matt.fleming@intel.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, jkosina@suse.cz, akpm@linux-foundation.org, chaowang@redhat.com

On 06/06/2014 12:37 AM, Dave Young wrote:
> On 06/05/14 at 11:01am, Vivek Goyal wrote:
>> On Thu, Jun 05, 2014 at 04:31:34PM +0800, Dave Young wrote:
>>
>> [..]
>>>> +	ret = kexec_file_load(kernel_fd, info.initrd_fd, info.command_line,
>>>> +			info.command_line_len, info.kexec_flags);
>>>
>>> Vivek,
>>>
>>> I tried your patch on my uefi test machine, but kexec load fails like below:
>>>
>>> [root@localhost ~]# kexec -l /boot/vmlinuz-3.15.0-rc8+ --use-kexec2-syscall
>>> Could not find a free area of memory of 0xa000 bytes ...
>>
>> Hi Dave,
>>
>> I think this message is coming from kexec-tools from old loading path. I
>> think somehow new path did not even kick in. I tried above and I got
>> -EBADF as I did not pass initrd. Can you run gdb on kexec and see if
>> you are getting to syscall or run strace.
> 
> Seems I can not reproduce the local hole fail issue but I'm sure it happens
> before the new syscall callback.
> 
> This time I got -ENOEXEC. It's caused by CONFIG_EFI_MIXED=y. In case EFI_MIXED
> 64bit kernel runs on 32bit efi firmware thus XLF_CAN_BE_LOADED_ABOVE_4G is not
> set thus bzImage probe will fail with NOEXEC.
> 

OK... this is seriously problematic.

#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_X86_64) && \
	!defined(CONFIG_EFI_MIXED)
   /* kernel/boot_param/ramdisk could be loaded above 4g */
# define XLF1 XLF_CAN_BE_LOADED_ABOVE_4G
#else
# define XLF1 0
#endif

The fact that even compiling with CONFIG_EFI_MIXED disables
XLF_CAN_BE_LOADED_ABOVE_4G is really not going to fly.  We should expect
CONFIG_EFI_MIXED to be the norm, but *also* should expect that there is
a legitimate need to load above 4G.

Matt, could you explain why this is necessary?  We need to figure out a
way around this.

My thinking is that disabling this flag is unnecessary, since a 32-bit
EFI loader should not load above the 4G mark anyway, but if I'm confused
and there is a more fundamental requirement, then we need to consider
that more carefully.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
