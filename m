Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L3Yi9-0003JV-9r
	for kexec@lists.infradead.org; Fri, 21 Nov 2008 16:18:25 +0000
Date: Fri, 21 Nov 2008 17:18:07 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 00/12] x86: disable virt on kdump and emergency_restart
	(v4)
Message-ID: <20081121161807.GB24839@elte.hu>
References: <1226955804-16802-1-git-send-email-ehabkost@redhat.com>
	<20081118081501.GF17838@elte.hu> <4926DCC8.1040500@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4926DCC8.1040500@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>


* Avi Kivity <avi@redhat.com> wrote:

> Ingo Molnar wrote:
>> * Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>>   
>>> Hi, Ingo,
>>>
>>> This is yet another spin of the series to disable vmx on kdump and  
>>> on emergency_restart, after some feedback from Avi.
>>>     
>>
>> this is going to interact with the KVM tree, wont it?
>>
>> i think the best way forward would be to keep your changes in the KVM  
>> tree.
>>
>> Lets try a Git trick for that. Avi could do that by pulling your other  
>> x86 changes from the x86 topic tree into the kvm tree. They are  
>> reviewed, acked and well-tested now, and kept in a separate tree so no  
>> other x86 change will be pulled in via them.
>>
>> We can do this if Avi can guarantee that these commits wont ever be  
>> rebased within KVM - then the two trees will merge up just fine in  
>> linux-next (and later in v2.6.29 as well), without any awkward merge  
>> dependencies or merge conflicts.
>>   
>
> I never rebase kvm.git master, so I pulled the x86 changes and 
> applied all.  Ingo, this will mean you have to push x86 before 
> kvm.git, but as you're generally faster than me there shouldn't be a 
> problem.

Great!

Note that the dependencies are even more relaxed that that: you can 
push it too via the KVM tree, independently of the x86 push. Obviously 
you got those x86 changes from us x86 maintainers and they all work 
standalone too.

Pulling from each other means both sides agree on that sub-set of 
changes and trust each other - so there's no forced merge ordering or 
maintenance boundaries - any side can merge it upstream. (If you feel 
uneasy about it on any level, and were you to send a pull request 
first, then you can point it out to Linus in the pull request that you 
got those changes from us.)

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
