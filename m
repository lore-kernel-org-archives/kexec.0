Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V2Xuo-0003xo-Vz
 for kexec@lists.infradead.org; Fri, 26 Jul 2013 02:38:00 +0000
Date: Fri, 26 Jul 2013 11:37:34 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec -p fails on kernel versions of form x.y
Message-ID: <20130726023733.GE28912@verge.net.au>
References: <1374790869-14661-1-git-send-email-khalid@gonehiking.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1374790869-14661-1-git-send-email-khalid@gonehiking.org>
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
To: Khalid Aziz <khalid@gonehiking.org>
Cc: kexec@lists.infradead.org, ebiederman@xmission.com

On Thu, Jul 25, 2013 at 04:21:09PM -0600, Khalid Aziz wrote:
> "kexec -p" fails to load kernels with version of the form x.y instead of
> x.y.z with an error message similar to "Unsupported utsname.release:
> 3.10-1-amd64". Code in kernel_version() also checks the wrong variable
> name for error return value from strtoul() for "minor" and "patch", and
> hence possibly missing a real error.
> 
> These changes fix both of these problems.
> 
> Signed-off-by: Khalid Aziz <khalid@gonehiking.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
