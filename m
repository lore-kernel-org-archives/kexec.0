Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxjcT-0005Lb-A6
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 14:44:29 +0000
Date: Wed, 5 Nov 2008 09:44:12 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 00/14] x86: disable virt on kdump and emergency_restart
Message-ID: <20081105144412.GD8993@redhat.com>
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<49107E2C.8090803@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49107E2C.8090803@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com

On Tue, Nov 04, 2008 at 06:54:04PM +0200, Avi Kivity wrote:
> Eduardo Habkost wrote:
>> Hi,
>>
>> This is a new version of the series to disabling virtualization on kdump,
>> now extended to do the same tricks on emergency_restart() if needed.
>>   
>
> Looks good.  If you me to push it upstream, I'll need kexec/kdump acks.   
> Otherwise, ack for the kvm bits.

Looks good to me from kdump perspective.

Is there a way we can prevent any other module from using virt disable
callback incase kvm is not loaded?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
