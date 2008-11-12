Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0PIe-0007EK-CS
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 23:39:05 +0000
Message-ID: <491B6855.1080609@kernel.org>
Date: Wed, 12 Nov 2008 15:35:49 -0800
From: "H. Peter Anvin" <hpa@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Always use 64 bit addresses for the firmware memory map
References: <1226519089-21647-1-git-send-email-bwalle@suse.de>	<491B358D.2040304@kernel.org>
	<20081112221106.5d9d7801@kopernikus.site>
In-Reply-To: <20081112221106.5d9d7801@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Bernhard Walle wrote:
> * H. Peter Anvin [2008-11-12 11:59]:
>> I want to make sure, though, that we don't just end up pushing the
>> truncation further down in the code.
> 
> Well, I think that interface should export the BIOS memmap as provided.
> Since E820 does provide 64 bit addresses, that should get exported.
> 
> It should even possible to kexec a PAE kernel from a non PAE kernel ...
> I didn't test, but it could work. But only if the E820 map is correctly
> written in the zero page, which is only the case if we get it correctly.
> 

That's fine, but we do have to check that we don't truncate elsewhere.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
