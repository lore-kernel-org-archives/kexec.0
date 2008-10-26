Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ku51G-0002Fk-FY
	for kexec@lists.infradead.org; Sun, 26 Oct 2008 12:46:58 +0000
Message-ID: <490466B7.7050704@redhat.com>
Date: Sun, 26 Oct 2008 14:46:47 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <20081023194129.GD27959@blackpad>
In-Reply-To: <20081023194129.GD27959@blackpad>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, kvm@vger.kernel.org

Eduardo Habkost wrote:
> Considering they touch both KVM and kexec, which tree would be best way
> to get them in?
>
>   

kvm.git will be happy to hold these patches, provided they are acked by 
the relevant maintainer.

> (Avi: the patches were sent only to kexec and kvm mailing lists,
> initially. If it's better to submit them to your address also so it gets
> on your queue, please let me know)
>   

Please do copy me.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
