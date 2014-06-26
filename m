Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-f47.google.com ([209.85.215.47])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X0Gpt-0004aU-IJ
 for kexec@lists.infradead.org; Thu, 26 Jun 2014 21:04:02 +0000
Received: by mail-la0-f47.google.com with SMTP id s18so2285300lam.20
 for <kexec@lists.infradead.org>; Thu, 26 Jun 2014 14:03:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140626204303.GE11136@redhat.com>
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
 <1403814824-7587-9-git-send-email-vgoyal@redhat.com>
 <20140626204303.GE11136@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 26 Jun 2014 14:03:17 -0700
Message-ID: <CALCETrU8mixFxpS2Bt2Q7S08zUFxZwE1zfqHw8PEetqewgR7RQ@mail.gmail.com>
Subject: Re: [PATCH 08/15] kexec: New syscall kexec_file_load() declaration
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, bhe@redhat.com, Greg Kroah-Hartman <greg@kroah.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linux API <linux-api@vger.kernel.org>, dyoung@redhat.com, chaowang@redhat.com, Michael Kerrisk-manpages <mtk.manpages@gmail.com>

On Thu, Jun 26, 2014 at 1:43 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Thu, Jun 26, 2014 at 04:33:37PM -0400, Vivek Goyal wrote:
>> This is the new syscall kexec_file_load() declaration/interface. I have
>> reserved the syscall number only for x86_64 so far. Other architectures
>> (including i386) can reserve syscall number when they enable the support
>> for this new syscall.
>>
>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>> CC: linux-api@vger.kernel.org
>
> +.BR KEXEC_FILE_NO_INITRAMFS
> +Loading initrd/initramfs is optional. Specify this flag if no initramfs
> +is being loaded. If this flag is set, kernel will ignore the value passed
> +in

This seems pointless.  Why not just pass -1 for initrd_fd to indicate
that no initrd is needed?

--Andy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
