Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx5Zl-0006ha-Gp
 for kexec@lists.infradead.org; Tue, 04 Sep 2018 07:16:39 +0000
Date: Tue, 4 Sep 2018 15:16:20 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
Message-ID: <20180904071620.GL1740@192.168.1.3>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
 <20180904060649.GK1740@192.168.1.3>
 <44fc1530-eb88-d8c5-7465-e48c91799a98@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44fc1530-eb88-d8c5-7465-e48c91799a98@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

On 09/03/18 at 11:36pm, H. Peter Anvin wrote:
> On 09/03/18 23:06, Baoquan He wrote:
> >>
> >> That makes no sense.  I'm talking about *entering* the kernel; the second
> >> kernel should switch to 5-level mode as necessary.
> > 
> > OK, I didn't get your point. I forget what difficulty was met so that
> > Kirill need to take this way. In that way, we will never have chance to
> > put kernel above 64TB even from 5-level kernel to jump to 5-level
> > kernel.
> > 
> 
> It sounds like you have no intent of doing that anyway?  Now, that is
> something one could use an xloadflag for, as I previously stated: "this kernel
> supports being entered in 5-level mode."

I am willing to take any better way to improve. May need to make clear
why that was not taken. Not sure if Kirill still has the details.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
