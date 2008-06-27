Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCEah-0000bq-A1
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 14:06:20 +0000
Date: Fri, 27 Jun 2008 16:06:56 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
Message-ID: <20080627160656.06f71661@halley.suse.de>
In-Reply-To: <20080627134212.GC5801@redhat.com>
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<20080627134212.GC5801@redhat.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

* Vivek Goyal [2008-06-27 09:42]:
> 
> Thinking more about. Let me step back. I think it is not good idea to
> take this kernel take decision about the capability of kernel being
> loaded. There is no way we can find out now that if a kernel is capable
> of running from this memory location or not. This is highly variable. So,
> please ignore above comment.

Maybe below 4G makes sense. Because you need some 32 bit memory for DMA.
That's mostly an architecture limitation, so that could make sense to
check here.

But I don't have any strong opinion about that.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
