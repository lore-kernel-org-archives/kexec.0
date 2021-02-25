Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF4Qz-0003pj-Ak
 for kexec@lists.infradead.org; Thu, 25 Feb 2021 00:23:15 +0000
Received: by mail-pl1-f198.google.com with SMTP id d11so2483891plh.13
 for <kexec@lists.infradead.org>; Wed, 24 Feb 2021 16:23:10 -0800 (PST)
Date: Thu, 25 Feb 2021 08:21:01 +0800
From: Coiby Xu <coxu@redhat.com>
Subject: Re: [RFC PATCH 4/4] i40e: don't open i40iw client for kdump
Message-ID: <20210225002101.hvbpq7f6zbvylqy4@Rk>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210224114141.ziywca4dvn5fs6js@Rk>
 <20210224084841.50620776@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <20210224084841.50620776@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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

On Wed, Feb 24, 2021 at 08:48:41AM -0800, Jakub Kicinski wrote:
>On Wed, 24 Feb 2021 19:41:41 +0800 Coiby Xu wrote:
>> On Tue, Feb 23, 2021 at 12:22:07PM -0800, Jakub Kicinski wrote:
>> >On Mon, 22 Feb 2021 15:07:01 +0800 Coiby Xu wrote:
>> >> i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
>> >> i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
>> >> for 1GbE while "craskernel=auto" only reserved 160M. With the module
>> >> parameter "resource_profile=2", we can reduce the memory usage of i40iw
>> >> to ~300M which is still too much for kdump.
>> >>
>> >> Disabling the client registration would spare us the client interface
>> >> operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
>> >> saved for kdump.
>> >>
>> >> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> >Is i40iw or whatever the client is not itself under a CONFIG which
>> >kdump() kernels could be reasonably expected to disable?
>> >
>>
>> I'm not sure if I understand you correctly. Do you mean we shouldn't
>> disable i40iw for kdump?
>
>Forgive my ignorance - are the kdump kernels separate builds?
>

AFAIK we don't build a kernel exclusively for kdump. 

>If they are it'd be better to leave the choice of enabling RDMA
>to the user - through appropriate Kconfig options.
>

i40iw is usually built as a loadable module. So if we want to leave the
choce of enabling RDMA to the user, we could exclude this driver when
building the initramfs for kdump, for example, dracut provides the 
omit_drivers option for this purpose. 

On the other hand, the users expect "crashkernel=auto" to work out of
the box. So i40iw defeats this purpose. 

I'll discuss with my Red Hat team and the Intel team about whether RDMA
is needed for kdump. Thanks for bringing up this issue!

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
