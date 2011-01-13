Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([93.93.128.6])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PdQCO-0000HY-6v
	for kexec@lists.infradead.org; Thu, 13 Jan 2011 16:38:57 +0000
Date: Thu, 13 Jan 2011 16:38:38 +0000
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH v2][EFI] Run EFI in physical mode
Message-ID: <20110113163838.GA21289@srcf.ucam.org>
References: <F7CB3D97D99F33indou.takao@jp.fujitsu.com>
	<4D06E7FE.5000600@jp.fujitsu.com>
	<9CB9BB8ED64BAindou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9CB9BB8ED64BAindou.takao@jp.fujitsu.com>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: nhorman@tuxdriver.com, horms@verge.net.au, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, tglx@linutronix.de, vgoyal@redhat.com

We're seeing issues with some Dell hardware when EFI is run in physical 
mode - it seems that Windows uses virtual mode, so the physical path is 
never exercised. I'm not sure that changing the default to physical is 
going to be possible without compatibility issues.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
