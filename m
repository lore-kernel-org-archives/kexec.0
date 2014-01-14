Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3Dm5-0004r8-4L
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 23:52:01 +0000
Date: Wed, 15 Jan 2014 08:51:37 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: print white-space characters
Message-ID: <20140114235137.GB8769@verge.net.au>
References: <20140114082624.GA2351@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140114082624.GA2351@dhcp-17-89.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org

On Tue, Jan 14, 2014 at 04:26:24PM +0800, WANG Chao wrote:
> Some sort of space like "\t" "\n" are used in kernel log. But we treat
> them as non-printables and output "\x20%x" for each non-printable. So
> let's fix it.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
