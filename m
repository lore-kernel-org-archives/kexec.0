Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKpgZ-0007gx-Vr
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:42:36 +0000
Date: Wed, 27 Mar 2013 21:42:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 13/13] kexec: x86_64: elf: fix possible memory leak in
 elf_x86_64_load
Message-ID: <20130327124233.GZ17248@verge.net.au>
References: <51506758.4070902@gmail.com>
 <51506ABB.2030808@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51506ABB.2030808@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, Mar 25, 2013 at 11:18:19PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> In elf_x86_64_load, allocated memory may not be free'd if the code
> exits abnormally, by calling die() or return. So the patch fixes
> the possible memory leak.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
