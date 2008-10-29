Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvHfO-0005x8-Kn
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 20:29:23 +0000
Message-ID: <4908C7A7.1090700@redhat.com>
Date: Wed, 29 Oct 2008 22:29:27 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <20081026213927.GF23893@blackpad>
	<490581A9.80108@redhat.com> <20081027130937.GA28226@redhat.com>
	<20081029201006.GT23893@blackpad>
In-Reply-To: <20081029201006.GT23893@blackpad>
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
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Eduardo Habkost wrote:
>> We boot kdump kernel with maxcpus=1. IIUC, in that code path we will not
>> be using INIT. So did you try booting kdump kernel with maxcpus=1 and did
>> it work for you? If not than problem could be something else.
>>     

vmx also disallows changing some bits in cr0 and cr4; for example you 
can't switch off paging.  This may interfere with the boot sequence.

The full set of pleasant surprises is detailed in section 19.8 of the 
SDM volume 3, "RESTRICTIONS ON VMX OPERATION".

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
