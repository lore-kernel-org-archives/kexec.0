Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEsYW-00062C-O0
 for kexec@lists.infradead.org; Wed, 24 Feb 2021 11:42:13 +0000
Received: by mail-pf1-f197.google.com with SMTP id z8so948964pfn.6
 for <kexec@lists.infradead.org>; Wed, 24 Feb 2021 03:42:09 -0800 (PST)
Date: Wed, 24 Feb 2021 19:41:41 +0800
From: Coiby Xu <coxu@redhat.com>
Subject: Re: [RFC PATCH 4/4] i40e: don't open i40iw client for kdump
Message-ID: <20210224114141.ziywca4dvn5fs6js@Rk>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, open list <linux-kernel@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, "David S. Miller" <davem@davemloft.net>

Hi Jakub,

Thank you for reviewing the patch!

On Tue, Feb 23, 2021 at 12:22:07PM -0800, Jakub Kicinski wrote:
>On Mon, 22 Feb 2021 15:07:01 +0800 Coiby Xu wrote:
>> i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
>> i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
>> for 1GbE while "craskernel=auto" only reserved 160M. With the module
>> parameter "resource_profile=2", we can reduce the memory usage of i40iw
>> to ~300M which is still too much for kdump.
>>
>> Disabling the client registration would spare us the client interface
>> operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
>> saved for kdump.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Is i40iw or whatever the client is not itself under a CONFIG which
>kdump() kernels could be reasonably expected to disable?
>

I'm not sure if I understand you correctly. Do you mean we shouldn't
disable i40iw for kdump?

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
