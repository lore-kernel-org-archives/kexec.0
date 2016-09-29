Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpcIv-0003fX-W7
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 14:27:21 +0000
Received: by mail-pf0-x22b.google.com with SMTP id q2so29610341pfj.3
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 07:26:54 -0700 (PDT)
Date: Thu, 29 Sep 2016 07:26:48 -0700
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3 0/8] (kexec-tools) arm64: add kdump support
Message-ID: <20160929142646.GB5218@localhost>
References: <20160907043401.6403-1-takahiro.akashi@linaro.org>
 <20160929075200.GE14497@verge.net.au>
 <20160929081805.GA5218@localhost>
 <20160929083909.GI14497@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160929083909.GI14497@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org

Simon,

On Thu, Sep 29, 2016 at 10:39:09AM +0200, Simon Horman wrote:
> On Thu, Sep 29, 2016 at 01:18:06AM -0700, AKASHI Takahiro wrote:
> > On Thu, Sep 29, 2016 at 09:52:00AM +0200, Simon Horman wrote:
> > > On Wed, Sep 07, 2016 at 01:33:53PM +0900, AKASHI Takahiro wrote:
> > > > My kernel patches of kdump suport on arm64 are currently under reviews.
> > > > 
> > > > This patchset is synced with them (v26 [1]) and provides necessary changes
> > > > for kexec-tools. It should be applied on top of Geoff's kexec-tools patches
> > > > v5[2] along with a bugfix[3].
> > > > 
> > > > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/454588.html
> > > > [2] http://lists.infradead.org/pipermail/kexec/2016-September/017110.html
> > > > [3] http://lists.infradead.org/pipermail/kexec/2016-July/016664.html
> > > 
> > > Unfortunately patch 2 does not seem to apply cleanly any more.
> > > Could you consider rebasing if you think this series is ready to be
> > > applied?
> > 
> > Yes, I will as there will be some changes needed again due to the discussions
> > on my kernel patch.
> > 
> > BTW, can you give me your opinion on my question, please?
> > 
> > http://lists.infradead.org/pipermail/kexec/2016-September/017119.html
> 
> I'm not particularly familiar with UEFI systems but for DT something under
> chosen seems to make sense.
> 
> Regarding Mark's objections to a memmap= command line parameter.
> Perhaps that could be discussed further in the context that even
> though it is not particularly attractive it it being used on other
> architecture(s).


Oops, my question was not accurate here.
Instead, see the discussions:
http://lists.infradead.org/pipermail/kexec/2016-July/016686.html

The issue is the end address in a memory range can be handled
differently across various architectures.
So we are in a messy situation.

Thanks,
-Takahiro AKASHI



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
