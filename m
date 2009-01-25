Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LREgl-00036v-Tg
	for kexec@lists.infradead.org; Sun, 25 Jan 2009 23:47:05 +0000
Date: Mon, 26 Jan 2009 10:46:50 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch] Possible fix for kexec-tools dynamic range allocation
Message-ID: <20090125234648.GF9347@verge.net.au>
References: <20090120212959.GA3564@verge.net.au> <4979AA81.8030300@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4979AA81.8030300@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chandru <chandru@in.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, Bernhard Walle <bwalle@suse.de>, mohan@in.ibm.com, kexec@lists.infradead.org

On Fri, Jan 23, 2009 at 05:01:13PM +0530, Chandru wrote:
> Simon Horman wrote:
>>
>> Does Bernhard's recent patch (sorry that I applied it even though
>> it came in after your patch) help this problem?
>>
>> commit 95c74405638c786bc76fbca5e4e8427dfe26e907
>> Author: Bernhard Walle <bwalle@suse.de>
>> Date:   Fri Jan 16 19:11:34 2009 +0100
>> Subject: Fix memory corruption when using realloc_memory_ranges()
>>
>>   
> 'git clone' or 'git pull' isn't showing these patches. The last commit  
> that I can see is : 6d4cdf4f94bf7ad2d1752b553ea948385881ff79 and search  
> by that commit doesn't yield anything :(.

Sorry, I had forgotten to push. The changes should be there now.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
