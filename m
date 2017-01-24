Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cW5mB-0007DQ-V7
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 18:25:05 +0000
Received: by mail-ua0-f196.google.com with SMTP id d5so17111559uag.0
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 10:24:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <20170106020324.GB2863@dhcp-128-65.nay.redhat.com>
 <38a7807c-cd95-670d-30d3-c45e7921ea11@linux.vnet.ibm.com>
 <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
From: Tony Luck <tony.luck@gmail.com>
Date: Tue, 24 Jan 2017 10:23:41 -0800
Message-ID: <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] ia64: reuse append_elf_note() and final_note()
 functions
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, kexec-ml <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On Tue, Jan 24, 2017 at 10:11 AM, Hari Bathini
<hbathini@linux.vnet.ibm.com> wrote:

> Hello IA64 folks,
>
> Could you please review this patch..?

It looks OK in principal.  My lab is in partial disarray at the
moment (just got back from a sabbatical) so I can't test
build and boot. Have you cross-compiled it (or gotten a success
build report from zero-day)?

If you have ... then add an Acked-by: Tony Luck <tony.luck@intel.com>

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
