Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: RFC on Kdump and PCIe on ARM64
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
 <20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
 <2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
 <20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
 <20180302103032.GB19323@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <84121a8d-5294-0567-6c6b-f57e85dc4961@codeaurora.org>
Date: Fri, 2 Mar 2018 09:12:29 -0500
MIME-Version: 1.0
In-Reply-To: <20180302103032.GB19323@arm.com>
Content-Language: en-US
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
To: Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Vikram Sethi <vikrams@codeaurora.org>, Linux PCI <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, Nate Watterson <nwatters@codeaurora.org>, "Goel, Sameer" <sgoel@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, "shankerd@codeaurora.org" <shankerd@codeaurora.org>

Hi Will,

On 3/2/2018 5:30 AM, Will Deacon wrote:
>> Do you really have to reset the IOMMU?  Can you just give it new page
>> tables that start out with all IOVAs from all devices being invalid,
>> then add valid mappings as drivers need them (presumably after the
>> driver has done whatever it needs to so the device stops using the old
>> DMA addresses)?
> We already have the option to do that via the command line using the
> disable_bypass option, so it just sounds like we need to take this into
> account when resetting the SMMU to take care that GBPA is configured so
> that transactions are terminated when SMMUEN=0.

How about the points that Baoquan highlighted in his email regarding the
solution from AMD and X86?

I have not read the entire thread but, is this just a matter of following
what Bjorn recommended or there is more to it?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
