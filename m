Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8qys-0002jH-GA
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 11:39:59 +0000
Message-ID: <51275909.5020801@citrix.com>
Date: Fri, 22 Feb 2013 11:39:53 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 0/4] kexec-tools: add support for Xen 4.3
References: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
 <512736DA02000078000C038C@nat28.tlf.novell.com>
In-Reply-To: <512736DA02000078000C038C@nat28.tlf.novell.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 22/02/13 08:14, Jan Beulich wrote:
>>>> On 21.02.13 at 18:57, David Vrabel <david.vrabel@citrix.com> wrote:
>> The series adds support for the new hypercall ABI which should be
>> provided by Xen 4.3.  Images are loaded into Xen directly with no
>> kernel involvement.
>>
>> Do not apply until the hypervisor side patches are applied to Xen.
>>
>> Patch 1 is unrelated but kexec wouldn't work for me without it. Not
>> sure why I had problems, perhaps a toolstack specific issue?
>>
>> Patch 2 makes libxc 4.3 mandatory for Xen support.
> 
> That doesn't sound right. How do you envision this to be
> incorporated into existing distros that don't right away switch
> to Xen 4.3?

Eric Bierderman said in an earlier thread[1]:

"Certainly /sbin/kexec will only support the new hypercall once the
support has merged."

David

[1] http://lists.xen.org/archives/html/xen-devel/2013-01/msg00754.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
