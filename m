Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T1Aku-0005mh-Jv
 for kexec@lists.infradead.org; Tue, 14 Aug 2012 06:37:33 +0000
Received: (from localhost user: 'dkiper' uid#4000 fake: STDIN
 (dkiper@router-fw.net-space.pl)) by router-fw-old.local.net-space.pl
 id S1596072Ab2HNGhT (ORCPT <rfc822;kexec@lists.infradead.org>);
 Tue, 14 Aug 2012 08:37:19 +0200
Date: Tue, 14 Aug 2012 08:37:19 +0200
From: Daniel Kiper <dkiper@net-space.pl>
Subject: Re: kexec in DomU of xen
Message-ID: <20120814063719.GA30600@router-fw-old.local.net-space.pl>
References: <CAF41zFy-TF1yzCracNPW_G33UpvfseqhvX-mVaDjwvmN=Dk8hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF41zFy-TF1yzCracNPW_G33UpvfseqhvX-mVaDjwvmN=Dk8hQ@mail.gmail.com>
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
To: weijia wang <aawwjaa@gmail.com>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Fri, Aug 10, 2012 at 05:29:18PM +0200, weijia wang wrote:
> Hi,
>
>    I am wandering that if kexec has supported the DomU of xen?
>    Because when I failed to use kexec for reloading a kernel in DomU.

Not yet. It is WIP. First I am going to publish support for dom0.
It contains changes required for domU Linux Kernel side, too.
However, there are also some changes required for Xen itself
and kexec-tools. Stay tuned.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
