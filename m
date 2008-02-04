Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JM76H-0004Lb-5T
	for kexec@lists.infradead.org; Mon, 04 Feb 2008 19:35:36 +0000
Date: Mon, 4 Feb 2008 20:35:25 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [mm] Crashkernel memory reservation fails with 2.6.24-rc8-mm1
Message-ID: <20080204193524.GA11104@suse.de>
References: <47A7391F.2020408@in.ibm.com> <20080204183810.GE16021@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080204183810.GE16021@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>, "Sachin P. Sant" <sachinp@in.ibm.com>

* Vivek Goyal <vgoyal@redhat.com> [2008-02-04 19:38]:
> 
> Bernahard, any idea who is the competitor here?

Hm ..., can you boot the kernel without crashkernel= and provide the
/proc/iomem?


        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
