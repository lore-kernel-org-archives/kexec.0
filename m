Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cg61w-00078X-JY
 for kexec@lists.infradead.org; Tue, 21 Feb 2017 08:42:42 +0000
Date: Tue, 21 Feb 2017 09:41:50 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
Message-ID: <20170221084149.sjah7ozcqkpy3vhv@pd.tnic>
References: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
 <20170220110941.vwcm3je3e4kkei6o@pd.tnic>
 <58AAEF34.9000303@redhat.com>
 <20170220202654.kakjxgmxrlhak6q3@pd.tnic>
 <58AB97B4.8040303@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58AB97B4.8040303@redhat.com>
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
To: xlpang@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Tue, Feb 21, 2017 at 09:28:20AM +0800, Xunlei Pang wrote:
> Not kdump kernel starts dumping, just during nmi_shootdown_cpus(), if some
> MCE comes after crashing_cpu was set and we don't skip crashing_cpu, then
> the crashing cpu will enter mce handler and trigger the synchronization issue.

Ok, I went and looked at __crash_kexec() - so we do nmi_shootdown_cpus()
as part of machine_crash_shutdown(). The next thing we do is kexec the
new kernel in machine_kexec(kexec_crash_image). The picture is clearer
now.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
