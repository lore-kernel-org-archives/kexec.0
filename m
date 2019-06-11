Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hadxD-0002NU-6Q
 for kexec@lists.infradead.org; Tue, 11 Jun 2019 10:24:37 +0000
Date: Tue, 11 Jun 2019 18:24:28 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: The current SME implementation fails kexec/kdump kernel booting.
Message-ID: <20190611102428.GF26148@MiWiFi-R3L-srv>
References: <20190604134952.GC26891@MiWiFi-R3L-srv>
 <508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com>
 <20190605005600.GF26891@MiWiFi-R3L-srv>
 <0d9fba9d-7bbe-a7c7-dfe4-696da0dfecc4@amd.com>
 <2fe0e56c-9286-b71d-3d6d-c2a6fbcfba89@redhat.com>
 <33b9237f-5e8c-fe49-4f55-220ce9a492fb@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33b9237f-5e8c-fe49-4f55-220ce9a492fb@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Tom,

On 06/11/19 at 05:52pm, lijiang wrote:
> After applied Tom's patch, i changed the reserved memory(for crash kernel) to the
> above 256M(>256M), such as crashkernel=320M or 384M,512M..., the kdump kernel can
> work and successfully dump the vmcore.
> 
> But the kdump kernel always happened the panic or could not boot successfully in
> the 256M(<= 256M) case, and on HP machine, i noticed that it printed OOM, the kdump
> kernel was too smaller memory. But i never see the OOM on speedway machine(probably
> related to the earlyprintk, it doesn't work and it loses many logs).
> 
> After removing the option 'CONFIG_DEBUG_INFO' from .config, i tested again, the kdump
> kernel did not happen the panic in the 256M(crashkernel=256M), the kdump kernel can
> work and succeed to dump the vmcore on HP machine or speedway machine.
> 
> It seems that the small memory caused the previous failure in kdump kernel. I would
> suggest to post this patch to upstream. What's your opinion? Tom, Baoquan and other
> people. Or do you have any comment?

As Lianbo said at above, the previous failure in kdump kernel is caused
by OOM. Just the log on speedway is incomplete, I am not sure what
happened. Now after investigation, your patch works to fix the issue.
Could you post it for riviewing?

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
