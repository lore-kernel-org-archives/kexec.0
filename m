Return-path: <kexec-bounces@lists.infradead.org>
Received: from www17.your-server.de ([213.133.104.17])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IhuD0-0006e8-7d
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 22:44:18 +0100
Message-ID: <47152FE6.3050204@m3y3r.de>
Date: Tue, 16 Oct 2007 23:40:54 +0200
From: Thomas Meyer <thomas@m3y3r.de>
MIME-Version: 1.0
Subject: Re: kexec: Cannot determine the file type of arch/x86/boot/bzImage
References: <47151631.9000307@m3y3r.de>
	<20071016130657.8cc17011.randy.dunlap@oracle.com>
In-Reply-To: <20071016130657.8cc17011.randy.dunlap@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: sam@ravnborg.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Randy Dunlap schrieb:
> On Tue, 16 Oct 2007 21:51:13 +0200 Thomas Meyer wrote:
>
> [adding kexec mailing list]
>
>   
>> Look at this:
>>
>> $ file arch/x86/boot/bzImage (tree 821f3eff7cdb9d6c7076effabd46c96c322daed1)
>> arch/x86/boot/bzImage: Linux kernel x86 boot executable zImage, version
>> 2.6.23 (thomas@hotzenplotz) #39, RO-rootFS, root_dev 0x803, swap_dev
>> 0x1, Prompt for Videomode
>>
>> $ file /boot/bzImage-2.6.23
>> /boot/bzImage-2.6.23: Linux kernel x86 boot executable RO-rootFS,
>> root_dev 0x803, swap_dev 0x1, Normal VGA
>>
>> and this:
>>
>> # kexec -l arch/x86/boot/bzImage
>> Cannot determine the file type of arch/x86/boot/bzImage
>>
>> How to solve this error?
>>     
$ git bisect good
f77bf01425b11947eeb3b5b54685212c302741b8 is first bad commit
commit f77bf01425b11947eeb3b5b54685212c302741b8
Author: Sam Ravnborg <sam@neptun.(none)>
Date:   Mon Oct 15 22:25:06 2007 +0200

    kbuild: introduce ccflags-y, asflags-y and ldflags-y

    Introduce ccflags-y, asflags-y and ldflags-y so we soon can
    deprecate use of EXTRA_CFLAGS, EXTRA_AFLAGS and EXTRA_LDFLAGS.
    This patch does not touch any in-tree users - thats next round.
    Lets get this committed first and then fix the users of the
    soon to be deprecated variants next.

    The rationale behind this change is to introduce support for
    makefile fragments like:

    ccflags-$(CONFIG_WHATEVER_DEBUG) := -DDEBUG

    As a replacement for the uglier:
    ifeq ($(CONFIG_WHATEVER_DEBUG),y)
            EXTRA_CFLAGS := -DDEBUG
    endif

    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

:040000 040000 03915c7c738eefa31f2327521130df23b7dfe95e
e2a1677df3709813ff793fdfa77d80fff9b838a7 M      Documentation
:040000 040000 ff4ad149975df39509a18782341f1f8f6a32f07a
663bce3c08a0f2e107cecb0b29edc4fe9d5735a0 M      scripts






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
