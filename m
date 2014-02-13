Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WE47I-0005g9-Tc
 for kexec@lists.infradead.org; Thu, 13 Feb 2014 21:46:45 +0000
Date: Thu, 13 Feb 2014 16:46:19 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Message-ID: <20140213214619.GL30844@redhat.com>
References: <1392297055-31934-1-git-send-email-chaowang@redhat.com>
 <1392297055-31934-3-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392297055-31934-3-git-send-email-chaowang@redhat.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de

On Thu, Feb 13, 2014 at 09:10:53PM +0800, WANG Chao wrote:

[..]
> @@ -230,6 +231,8 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  		/* Only Dumping memory of type System RAM. */
>  		if (memcmp(str, "System RAM\n", 11) == 0) {
>  			type = RANGE_RAM;
> +		} else if (memcmp(str, "reserved\n", 9) == 0) {
> +			type = RANGE_RESERVED;

Hi Chao,

Can we take up the issue of passing reserved ranges to second kernel in
a separate patchset. I had noticed higher memory usage due to that and
it might have been something else.

It might be easier to handle one thing at a time. Let us first start
passing the memory range we pass on command line through bootparams and
once that gets merged and stablizes, write a patchset to start passing
reserved memory ranges if need be.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
