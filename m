Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1oyM-0001ou-PG
 for kexec@lists.infradead.org; Fri, 30 Mar 2018 08:01:20 +0000
Date: Fri, 30 Mar 2018 16:00:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 1/5] kexec: Return -ENOSYS when kexec does not know
 how to call KEXEC_FILE_LOAD
Message-ID: <20180330080058.GA4323@dhcp-128-65.nay.redhat.com>
References: <20180327095955.GB4681@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
 <20180330062928.234zvlgiwyfvqadd@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180330062928.234zvlgiwyfvqadd@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>, Petr Tesarik <ptesarik@suse.cz>, Tony Jones <tonyj@suse.com>

Hi Simon,

On 03/30/18 at 08:29am, Simon Horman wrote:
> Hi again Dave,
> 
> would you care to review v6?

I have no more comments for v6.  Overall looks good to me.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
