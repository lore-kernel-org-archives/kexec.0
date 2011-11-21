Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RSPcs-0005gL-AU
 for kexec@lists.infradead.org; Mon, 21 Nov 2011 08:53:18 +0000
Date: Mon, 21 Nov 2011 17:53:15 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] fix rpm build errors
Message-ID: <20111121085314.GD6187@verge.net.au>
References: <1321863964-12184-1-git-send-email-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1321863964-12184-1-git-send-email-xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

On Mon, Nov 21, 2011 at 04:26:04PM +0800, Cong Wang wrote:
> a) rpmbuild doesn't like '-' in version, replace it with '.'.
> b) update the files installed in kexec-tools.spec
> 
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
