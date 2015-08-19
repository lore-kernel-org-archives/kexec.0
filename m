Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZS36K-0004mi-Ug
 for kexec@lists.infradead.org; Wed, 19 Aug 2015 13:08:24 +0000
Date: Wed, 19 Aug 2015 21:13:02 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: Dmesg not being dumped
Message-ID: <20150819131302.GA11631@dhcp-128-25.nay.redhat.com>
References: <55D42056.5070709@kyup.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55D42056.5070709@kyup.com>
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
To: Nikolay Borisov <kernel@kyup.com>
Cc: kexec@lists.infradead.org

Hi. Nikolay.

Does kexec-tools work for original rhel kernel, like 3.10.0-xxx. Also do
you specify the config to build the kernel? It is appropriate if you can
paste the config related to the kexec.

Thanks
Minfei

On 08/19/15 at 09:21am, Nikolay Borisov wrote:
> Hello,
> 
> I've recently noticed that when creating crashdumps the dmesg is not
> being saved. The error reported is this: "Missing the struct log size
> export". I've tested with both kernel 4.1.1 and 3.12.28. My version of
> kexec tools is : kexec-tools 2.0.9 released 04 June 2015. The kernel has
> been compiled with debugging info so the respective symbol should be
> exported but apparently it is not. Any ideas how to debug that?
> 
> [Please CC me as I'm not subscribed to the mailing list.]
> 
> Regards,
> Nikolay
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
