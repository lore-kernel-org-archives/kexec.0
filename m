Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtAuB-00GS3M-BC
 for kexec@lists.infradead.org; Fri, 03 Dec 2021 15:55:25 +0000
Received: by mail-ua1-f70.google.com with SMTP id
 w48-20020a9f31f3000000b002cf15fe9655so1740007uad.17
 for <kexec@lists.infradead.org>; Fri, 03 Dec 2021 07:55:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+tGwnkDsuwOyDoZUNvi9ExhSsiF1MiGvegwjpQem8c3BPJ=6g@mail.gmail.com>
 <20211124134743.GB11728@MiWiFi-R3L-srv> <20211201021926.3xfabf5zbzidvrwa@Rk>
In-Reply-To: <20211201021926.3xfabf5zbzidvrwa@Rk>
From: Veronika Kabatova <vkabatov@redhat.com>
Date: Fri, 3 Dec 2021 16:54:19 +0100
Message-ID: <CA+tGwn==8PzG5UrnDe8_y+3M-QA446HK5tig1bjU3FY9uEkzQA@mail.gmail.com>
Subject: Re: Compile error ppc64le: Cannot find symbol for section 11:
 .text.unlikely.
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
To: Coiby Xu <coxu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, ebiederm@xmission.com

On Wed, Dec 1, 2021 at 3:20 AM Coiby Xu <coxu@redhat.com> wrote:
>
> On Wed, Nov 24, 2021 at 09:47:43PM +0800, Baoquan He wrote:
> >On 11/24/21 at 01:47pm, Veronika Kabatova wrote:
> >> Hi,
> >>
> >> for a while we've been seen the following error when compiling
> >> the mainline kernel with gcc 11.2 and binutils 2.37:
> >>
> >> 00:02:32 Cannot find symbol for section 11: .text.unlikely.
> >> 00:02:32 kernel/kexec_file.o: failed
> >> 00:02:32 make[3]: *** [scripts/Makefile.build:287: kernel/kexec_file.o] Error 1
> >> 00:02:32 make[3]: *** Deleting file 'kernel/kexec_file.o'
> >> 00:02:32 make[2]: *** [Makefile:1846: kernel] Error 2
> >> 00:02:32 make[2]: *** Waiting for unfinished jobs....
> >>
> >> The error only happens with ppc64le. I've tested this with cross
> >> compilation, but the only reference to the error I found suggests
> >> the same happens with the native compiles as well:
> >>
> >> https://github.com/groeck/linux-build-test/commit/142cbefbc0d37962c9a6c7f28ee415ecd5fd1e98
> >>
> >> In case it matters, the config used is the Fedora config with
> >> kselftest options enabled, which you can grab from
> >>
> >> https://gitlab.com/redhat/red-hat-ci-tools/kernel/cki-internal-pipelines/cki-trusted-contributors/-/jobs/1760752896/artifacts/raw/artifacts/kernel-mainline.kernel.org-ppc64le-e4e737bb5c170df6135a127739a9e6148ee3da82.config
> >>
> >>
> >> I've reached out to the Fedora compiler folks and Nick Clifton
> >> suggested this is a problem with the kernel:
> >>
> >>     This message comes from the recordmcount tool, which is part of the kernel
> >>     sources:
> >>
> >>     linux/scripts/recordmcount.[ch]
> >>
> >>     It appears to be triggered when a compiler update causes code to be
> >>     rearranged. The problem has been reported before in various forums,
> >>     but in particular I found this reference:
> >>
> >>     https://lore.kernel.org/lkml/20201204165742.3815221-2-arnd@kernel.org/
> >>
> >>     The point of which to me at least is that this is a kernel issue rather than
> >>     a compiler issue.  Ie there must be some weak symbols in kexec_file.o file
> >>     which need to be moved elsewhere.
> >
> >It could be arch_kexec_kernel_verify_sig() in kernel/kexec_file.c which
> >is __weak, but not implemented in any ARCH. If true, this has been
> >pointed out by Eric in one patch thread from Coiby.
> >
> >[PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
> >http://lkml.kernel.org/r/20211018083137.338757-2-coxu@redhat.com
> >
> >Maybe Coiby can fetch above config file and run the test to check.
>
> "[PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig" alone
> would fix the error. If I turn arch_kexec_apply_relocations{_add,} into
> static function, the error would be gone. As attached is the patch would
> make this error disappear.
>

Thank you! I can confirm the attached patch fixes the problem.


Veronika

> However, s390 and x86 have its own implementation of
> arch_kexec_apply_relocations_add. This makes it looks like to be gcc's
> issue.
>
>
> >
> >Thanks
> >Baoquan
> >
>
> --
> Best regards,
> Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
