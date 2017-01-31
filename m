Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cYgoC-0007fs-RD
 for kexec@lists.infradead.org; Tue, 31 Jan 2017 22:21:55 +0000
Received: by mail-wm0-x243.google.com with SMTP id r18so1341844wmd.3
 for <kexec@lists.infradead.org>; Tue, 31 Jan 2017 14:21:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <04b96f50-f77d-9446-975f-7d44accfe583@linux.vnet.ibm.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <20170106020324.GB2863@dhcp-128-65.nay.redhat.com>
 <38a7807c-cd95-670d-30d3-c45e7921ea11@linux.vnet.ibm.com>
 <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
 <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
 <04b96f50-f77d-9446-975f-7d44accfe583@linux.vnet.ibm.com>
From: Tony Luck <tony.luck@gmail.com>
Date: Tue, 31 Jan 2017 14:21:27 -0800
Message-ID: <CA+8MBbLP5TvmbDgbg6cvUCV+0hhXdYi546Rs-fEAoQjcotNXvw@mail.gmail.com>
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

On Wed, Jan 25, 2017 at 11:15 AM, Hari Bathini
<hbathini@linux.vnet.ibm.com> wrote:
> I haven't gotten a success/failure build report from zero-day. Not sure what
> to make of it.

zero-day is generally silent unless it sees a problem. So no news is good news.

> But I did try cross-compiling and it was successful. Should that do?

I guess so. What tree do these apply to?  I tried 4.10-rc5 and "git am"
protested ... but I didn't look closely as at why.

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
