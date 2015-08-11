Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZP58o-0006jS-28
 for kexec@lists.infradead.org; Tue, 11 Aug 2015 08:42:38 +0000
Date: Tue, 11 Aug 2015 16:42:12 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v2] align crash_notes allocation to make it be inside one
 physical page
Message-ID: <20150811084212.GD9748@dhcp-17-102.nay.redhat.com>
References: <1438606243-13064-1-git-send-email-bhe@redhat.com>
 <20150803150417.b3536887b1ad86ae04c405b7@linux-foundation.org>
 <20150811063333.GB9748@dhcp-17-102.nay.redhat.com>
 <20150811080108.GA2404@dhcp-128-25.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150811080108.GA2404@dhcp-128-25.nay.redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tatsu@ab.jp.nec.com, lisa.mitchell@hp.com, seiji.aguchi.tr@hitachi.com, Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

Hi,

On 08/11/15 at 04:01pm, Minfei Huang wrote:
> Baoquan.
> 
> If the size of notes never be exceeded to PAGE_SIZE, I think we can
> revert below patch, since the situation which describes in patch does
> not happen.
> 
>     commit 38dfac843cb6d7be1874888839817404a15a6b3c
>     Author: Greg Pearson <greg.pearson@hp.com>
>     Date:   Mon Feb 10 14:25:36 2014 -0800
>     
>         vmcore: prevent PT_NOTE p_memsz overflow during header update
> 
> What do you think about this?

Yeah, I am fine with this reverting. If people all agree with this I can
post patch to revert this. In fact I am eagerer to revert below commit
since it's  a littble bit confusing after crash_notes crossing 2
pages bug is fixed. Below commit is a work around fix , but it's too much. 
I am willing to hear people's idea.

commit 34b47764297130b21aaeb4cc6119bb811814b8e3
Author: WANG Chao <chaowang@redhat.com>
Date:   Tue Feb 17 13:46:01 2015 -0800

    vmcore: fix PT_NOTE n_namesz, n_descsz overflow issue

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
