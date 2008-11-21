Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L3YXs-00021z-4V
	for kexec@lists.infradead.org; Fri, 21 Nov 2008 16:07:48 +0000
Message-ID: <4926DCC8.1040500@redhat.com>
Date: Fri, 21 Nov 2008 18:07:36 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/12] x86: disable virt on kdump and emergency_restart
	(v4)
References: <1226955804-16802-1-git-send-email-ehabkost@redhat.com>
	<20081118081501.GF17838@elte.hu>
In-Reply-To: <20081118081501.GF17838@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Ingo Molnar wrote:
> * Eduardo Habkost <ehabkost@redhat.com> wrote:
>
>   
>> Hi, Ingo,
>>
>> This is yet another spin of the series to disable vmx on kdump and 
>> on emergency_restart, after some feedback from Avi.
>>     
>
> this is going to interact with the KVM tree, wont it?
>
> i think the best way forward would be to keep your changes in the KVM 
> tree.
>
> Lets try a Git trick for that. Avi could do that by pulling your other 
> x86 changes from the x86 topic tree into the kvm tree. They are 
> reviewed, acked and well-tested now, and kept in a separate tree so no 
> other x86 change will be pulled in via them.
>
> We can do this if Avi can guarantee that these commits wont ever be 
> rebased within KVM - then the two trees will merge up just fine in 
> linux-next (and later in v2.6.29 as well), without any awkward merge 
> dependencies or merge conflicts.
>   

I never rebase kvm.git master, so I pulled the x86 changes and applied 
all.  Ingo, this will mean you have to push x86 before kvm.git, but as 
you're generally faster than me there shouldn't be a problem.

Eduardo, please check the merge (there was a small conflict in reboot.c 
which I fixed) once I push it.  Also, when generating patches that move 
files, use the -M switch: this makes it easier to review, and also 
handles files that change better.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
