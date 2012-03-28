Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SD2lD-0001oz-6R
 for kexec@lists.infradead.org; Wed, 28 Mar 2012 23:58:39 +0000
Date: Thu, 29 Mar 2012 08:58:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Add a descriptive error message for kexec load failure
Message-ID: <20120328235831.GE31574@verge.net.au>
References: <20120328190902.GA7651@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120328190902.GA7651@hp.com>
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
To: Khalid Aziz <khalid@hp.com>
Cc: kexec@lists.infradead.org

On Wed, Mar 28, 2012 at 01:09:02PM -0600, Khalid Aziz wrote:
> kexec-tools package for debian includes a patch that adds a more 
> descriptive error message when someone tries to laod a crash kernel 
> and didn't remember to boot up with crashkernel= parameter. This 
> patch would be of general interest. This patch was originally written 
> by Alastair McKinstry.

Thanks for bringing this change in from the cold.

> Please apply.

Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
