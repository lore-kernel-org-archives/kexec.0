Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aasIC-00034A-4D
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 21:57:20 +0000
Date: Tue, 1 Mar 2016 13:56:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2 1/2] kexec: Make a pair of map/unmap reserved pages
 in error path
Message-Id: <20160301135658.341928989a18949d97998abd@linux-foundation.org>
In-Reply-To: <1456819349-8650-2-git-send-email-mnfhuang@gmail.com>
References: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
 <1456819349-8650-2-git-send-email-mnfhuang@gmail.com>
Mime-Version: 1.0
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
To: Minfei Huang <mnfhuang@gmail.com>
Cc: mhuang@redhat.com, kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On Tue,  1 Mar 2016 16:02:28 +0800 Minfei Huang <mnfhuang@gmail.com> wrote:

> For some arch, kexec shall map the reserved pages, then use them, when
> we try to start the kdump service.

Which architectures are these, by the way?

> kexec may return directly, without unmaping the reserved pages, if it
> fails during starting service. To fix it, we make a pair of map/unmap
> reserved pages both in generic path and error path.

I'm having trouble understanding the urgency of this patch.  Do you
think it is needed in 4.5?  -stable?  If so, why?

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
