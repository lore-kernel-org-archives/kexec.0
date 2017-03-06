Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ckxMm-0000xh-4o
 for kexec@lists.infradead.org; Mon, 06 Mar 2017 18:28:17 +0000
Date: Mon, 6 Mar 2017 10:27:54 -0800
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v4] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Message-ID: <20170306182754.GB29163@intel.com>
References: <1487857012-9059-1-git-send-email-xlpang@redhat.com>
 <20170306111654.xmmizzae4assppk3@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170306111654.xmmizzae4assppk3@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Xunlei Pang <xlpang@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Mon, Mar 06, 2017 at 12:16:54PM +0100, Borislav Petkov wrote:
> On Thu, Feb 23, 2017 at 09:36:52PM +0800, Xunlei Pang wrote:
> > We met an issue for kdump: after kdump kernel boots up,
> > and there comes a broadcasted mce in first kernel, the
> > other cpus remaining in first kernel will enter the old
> > mce handler of first kernel, then timeout and panic due
> > to MCE synchronization, finally reset the kdump cpus.
> > 
> > This patch lets cpus stay quiet after nmi_shootdown_cpus(),
> > so after kdump boots, cpus remaining in 1st kernel should
> > not do anything except clearing MCG_STATUS. This is useful
> > for kdump to let vmcore dumping perform as hard as it can.
> 
> Ok, I went and rewrote the text to make it more succinct, to the point
> and correct spelling and formatting.
> 
> Tony, ACK?

Yes. Looks good now.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
