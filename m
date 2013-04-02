Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMpkA-0002uv-Hk
 for kexec@lists.infradead.org; Tue, 02 Apr 2013 01:10:35 +0000
Date: Tue, 2 Apr 2013 10:10:32 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] [RFC] get rid of dist
Message-ID: <20130402011031.GD14785@verge.net.au>
References: <1364815385-26722-1-git-send-email-richard@nod.at>
 <1364815385-26722-2-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1364815385-26722-2-git-send-email-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: zhangyanfei@cn.fujitsu.com, kexec@lists.infradead.org

On Mon, Apr 01, 2013 at 01:23:05PM +0200, Richard Weinberger wrote:
> Replace the dist variable by git ls-files.
> The following files are now included in the dist tarball too:

I'm sorry but I don't think it is reasonable to
add git as a requirement for building a tarball.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
