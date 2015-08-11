Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZP38I-0007v3-Gk
 for kexec@lists.infradead.org; Tue, 11 Aug 2015 06:33:58 +0000
Date: Tue, 11 Aug 2015 14:33:33 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v2] align crash_notes allocation to make it be inside one
 physical page
Message-ID: <20150811063333.GB9748@dhcp-17-102.nay.redhat.com>
References: <1438606243-13064-1-git-send-email-bhe@redhat.com>
 <20150803150417.b3536887b1ad86ae04c405b7@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150803150417.b3536887b1ad86ae04c405b7@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tatsu@ab.jp.nec.com, lisa.mitchell@hp.com, seiji.aguchi.tr@hitachi.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

Hi Andrew,

On 08/03/15 at 03:04pm, Andrew Morton wrote:
> On Mon,  3 Aug 2015 20:50:43 +0800 Baoquan He <bhe@redhat.com> wrote:
> And I think the WARN_ON can be replaced with a
> BUILD_BUG_ON(sizeof>PAGE_SIZE)?  That would avoid adding runtime
> overhead.

Rethink about this, you are right. Using BUILD_BUG_ON is better.
Anyone who found this compiling break should check if his/her code
changes increase the crash_notes size. If possible that increase need be
avoidable. Otherwise he should report this to upstream why it's
unavoidable to increase crash_notes size, then let's consider the
redesign the crash_notes data structure. 

So I will use BUILD_BUG_ON and repost.

Thanks
Baoquan
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
