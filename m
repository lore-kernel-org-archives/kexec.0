Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uc6yE-0004pn-IF
 for kexec@lists.infradead.org; Tue, 14 May 2013 04:36:15 +0000
Date: Tue, 14 May 2013 13:35:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Replace printf() with die() to error out to stderr
Message-ID: <20130514043549.GI20239@verge.net.au>
References: <1368503808-16601-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1368503808-16601-1-git-send-email-chaowang@redhat.com>
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

On Tue, May 14, 2013 at 11:56:48AM +0800, WANG Chao wrote:
> Error messages are mixed stderr with stdout when we use die() along with
> printf(). So use die() to keep error out consistent.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
