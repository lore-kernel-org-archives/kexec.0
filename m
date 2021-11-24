Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mprit-004lLx-FS
 for kexec@lists.infradead.org; Wed, 24 Nov 2021 12:50:05 +0000
Received: by mail-ua1-f71.google.com with SMTP id
 w48-20020a9f31f3000000b002cf15fe9655so1635335uad.17
 for <kexec@lists.infradead.org>; Wed, 24 Nov 2021 04:48:08 -0800 (PST)
MIME-Version: 1.0
From: Veronika Kabatova <vkabatov@redhat.com>
Date: Wed, 24 Nov 2021 13:47:32 +0100
Message-ID: <CA+tGwnkDsuwOyDoZUNvi9ExhSsiF1MiGvegwjpQem8c3BPJ=6g@mail.gmail.com>
Subject: Compile error ppc64le: Cannot find symbol for section 11:
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
To: kexec@lists.infradead.org
Cc: ebiederm@xmission.com

Hi,

for a while we've been seen the following error when compiling
the mainline kernel with gcc 11.2 and binutils 2.37:

00:02:32 Cannot find symbol for section 11: .text.unlikely.
00:02:32 kernel/kexec_file.o: failed
00:02:32 make[3]: *** [scripts/Makefile.build:287: kernel/kexec_file.o] Error 1
00:02:32 make[3]: *** Deleting file 'kernel/kexec_file.o'
00:02:32 make[2]: *** [Makefile:1846: kernel] Error 2
00:02:32 make[2]: *** Waiting for unfinished jobs....

The error only happens with ppc64le. I've tested this with cross
compilation, but the only reference to the error I found suggests
the same happens with the native compiles as well:

https://github.com/groeck/linux-build-test/commit/142cbefbc0d37962c9a6c7f28ee415ecd5fd1e98

In case it matters, the config used is the Fedora config with
kselftest options enabled, which you can grab from

https://gitlab.com/redhat/red-hat-ci-tools/kernel/cki-internal-pipelines/cki-trusted-contributors/-/jobs/1760752896/artifacts/raw/artifacts/kernel-mainline.kernel.org-ppc64le-e4e737bb5c170df6135a127739a9e6148ee3da82.config


I've reached out to the Fedora compiler folks and Nick Clifton
suggested this is a problem with the kernel:

    This message comes from the recordmcount tool, which is part of the kernel
    sources:

    linux/scripts/recordmcount.[ch]

    It appears to be triggered when a compiler update causes code to be
    rearranged. The problem has been reported before in various forums,
    but in particular I found this reference:

    https://lore.kernel.org/lkml/20201204165742.3815221-2-arnd@kernel.org/

    The point of which to me at least is that this is a kernel issue rather than
    a compiler issue.  Ie there must be some weak symbols in kexec_file.o file
    which need to be moved elsewhere.


Is this something that is indeed an issue that should be fixed in the
kernel, or should I reach out to someone else? I'm happy to test any
patches provided.

Thank you,
Veronika


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
