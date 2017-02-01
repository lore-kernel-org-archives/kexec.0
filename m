Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cYjSq-0005m5-1r
 for kexec@lists.infradead.org; Wed, 01 Feb 2017 01:12:01 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/5] ia64: reuse append_elf_note() and final_note()
 functions
In-Reply-To: <CA+8MBbLP5TvmbDgbg6cvUCV+0hhXdYi546Rs-fEAoQjcotNXvw@mail.gmail.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <20170106020324.GB2863@dhcp-128-65.nay.redhat.com>
 <38a7807c-cd95-670d-30d3-c45e7921ea11@linux.vnet.ibm.com>
 <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
 <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
 <04b96f50-f77d-9446-975f-7d44accfe583@linux.vnet.ibm.com>
 <CA+8MBbLP5TvmbDgbg6cvUCV+0hhXdYi546Rs-fEAoQjcotNXvw@mail.gmail.com>
Date: Wed, 01 Feb 2017 12:11:28 +1100
Message-ID: <874m0evhof.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
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
To: Tony Luck <tony.luck@gmail.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec-ml <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Tony Luck <tony.luck@gmail.com> writes:

> On Wed, Jan 25, 2017 at 11:15 AM, Hari Bathini
> <hbathini@linux.vnet.ibm.com> wrote:
>> I haven't gotten a success/failure build report from zero-day. Not sure what
>> to make of it.
>
> zero-day is generally silent unless it sees a problem. So no news is good news.
>
>> But I did try cross-compiling and it was successful. Should that do?
>
> I guess so. What tree do these apply to?  I tried 4.10-rc5 and "git am"
> protested ... but I didn't look closely as at why.

Don't worry about it, I do an ia64_defconfig build as part of my usual
tests before pushing.

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
