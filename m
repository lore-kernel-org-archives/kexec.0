Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPSDX-0001RZ-OK
 for kexec@lists.infradead.org; Wed, 21 Nov 2018 13:06:57 +0000
Date: Wed, 21 Nov 2018 14:06:22 +0100
In-Reply-To: <ddeff176-2517-4b58-73b6-3787e84b2a5e@redhat.com>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com> <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
 <20181118115251.GB19380@zn.tnic>
 <ddeff176-2517-4b58-73b6-3787e84b2a5e@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
From: Boris Petkov <bp@alien8.de>
Message-ID: <49B3EB59-ABD2-4A5C-BE8A-B078283B8418@alien8.de>
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
To: lijiang <lijiang@redhat.com>
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On November 21, 2018 11:54:09 AM GMT+01:00, lijiang <lijiang@redhat.com> wrote:
>If you understood this issue, you might ignore it, please.

Yes,I got it. Simply figuring out which reserved regions to export and which not, is not worth the effort - we can do the simple thing of directly exporting them all.

Thx.

-- 
Sent from a small device: formatting sux and brevity is inevitable. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
