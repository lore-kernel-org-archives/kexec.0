Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PvIkZ-0004NZ-DO
	for kexec@lists.infradead.org; Fri, 04 Mar 2011 00:20:08 +0000
Date: Fri, 4 Mar 2011 09:20:03 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PULL] x86_64 kdump fixes
Message-ID: <20110304002003.GH15019@verge.net.au>
References: <m1k4gfswmx.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1k4gfswmx.fsf@fess.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Thu, Mar 03, 2011 at 01:48:54PM -0800, Eric W. Biederman wrote:
> 
> These are bug fixes that were tested several months ago and I forgot to
> ask for them to be pulled.  I have tested against the latest tree and
> these changes still apply and build cleanly.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/kexec-tools-devel.git 
> 
> 
> Eric W. Biederman (2):
>       kexec-syscall.h: Document what the architecture default arch is.
>       x86 crashdump: On x86_64 generate EM_X86_64 crashdump headers.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
