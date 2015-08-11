Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZP4QF-00087w-Pl
 for kexec@lists.infradead.org; Tue, 11 Aug 2015 07:56:36 +0000
Date: Tue, 11 Aug 2015 16:01:08 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [Patch v2] align crash_notes allocation to make it be inside one
 physical page
Message-ID: <20150811080108.GA2404@dhcp-128-25.nay.redhat.com>
References: <1438606243-13064-1-git-send-email-bhe@redhat.com>
 <20150803150417.b3536887b1ad86ae04c405b7@linux-foundation.org>
 <20150811063333.GB9748@dhcp-17-102.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150811063333.GB9748@dhcp-17-102.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tatsu@ab.jp.nec.com, lisa.mitchell@hp.com, seiji.aguchi.tr@hitachi.com, Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

On 08/11/15 at 02:33pm, Baoquan He wrote:
> Hi Andrew,
> 
> On 08/03/15 at 03:04pm, Andrew Morton wrote:
> > On Mon,  3 Aug 2015 20:50:43 +0800 Baoquan He <bhe@redhat.com> wrote:
> > And I think the WARN_ON can be replaced with a
> > BUILD_BUG_ON(sizeof>PAGE_SIZE)?  That would avoid adding runtime
> > overhead.
> 
> Rethink about this, you are right. Using BUILD_BUG_ON is better.
> Anyone who found this compiling break should check if his/her code
> changes increase the crash_notes size. If possible that increase need be
> avoidable. Otherwise he should report this to upstream why it's
> unavoidable to increase crash_notes size, then let's consider the
> redesign the crash_notes data structure. 
> 
> So I will use BUILD_BUG_ON and repost.

Baoquan.

If the size of notes never be exceeded to PAGE_SIZE, I think we can
revert below patch, since the situation which describes in patch does
not happen.

    commit 38dfac843cb6d7be1874888839817404a15a6b3c
    Author: Greg Pearson <greg.pearson@hp.com>
    Date:   Mon Feb 10 14:25:36 2014 -0800
    
        vmcore: prevent PT_NOTE p_memsz overflow during header update

What do you think about this?

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
