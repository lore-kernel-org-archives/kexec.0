Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1axXL2-0004Q7-Ag
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:14:06 +0000
Date: Tue, 3 May 2016 11:12:59 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/12] kexec: arrange for paddr_vmcoreinfo_note() to
 return phys_addr_t
Message-ID: <20160503101258.GL19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFP-0000je-5t@rmk-PC.arm.linux.org.uk>
 <CAHB_Gur-6oyEheN-Pom7OwivdvrQpCBaXvM1V2H0JPFRCFZthA@mail.gmail.com>
 <20160429151639.GC23726@leverpostej>
 <CAHB_GurwYqPbccLU9UHppLxbBr4Cfs47myKAer-RJicT=T7uBw@mail.gmail.com>
 <20160503042441.GA2518@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160503042441.GA2518@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: Pratyush Anand <panand@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Haren Myneni <hbabu@us.ibm.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

On Tue, May 03, 2016 at 12:24:41PM +0800, Baoquan He wrote:
> Could you please help tell why arm PAE kernel can be put above 4G?
> Since the change is related to common code, I am curious about how
> it's so different with other ARCHs.

This is explained in the covering email to the series.

The explanation given by Pratyush was incomplete.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
