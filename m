Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SLuU6-0005Zw-Ep
 for kexec@lists.infradead.org; Sun, 22 Apr 2012 10:57:39 +0000
Message-ID: <4F93E411.7070809@redhat.com>
Date: Sun, 22 Apr 2012 13:57:21 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F8FF7AC.1060309@redhat.com>
 <20120419.210119.246504497.d.hatayama@jp.fujitsu.com>
 <4F900020.5010702@redhat.com>
 <20120420.191133.488341439.d.hatayama@jp.fujitsu.com>
 <4F93D64B.50803@redhat.com> <20120422103340.GE12768@redhat.com>
In-Reply-To: <20120422103340.GE12768@redhat.com>
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
To: Gleb Natapov <gleb@redhat.com>
Cc: dzickus@redhat.com, luto@mit.edu, mtosatti@redhat.com, kvm@vger.kernel.org, joerg.roedel@amd.com, gregkh@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com, ludwig.nussel@suse.de

On 04/22/2012 01:33 PM, Gleb Natapov wrote:
> > 
> > What I don't understand is why you are interested in the guest machine
> > at all, if it was qemu that crashed.
> > 
> It would be interesting to extract enough information from the core to be
> able to restart the guest from the point where qemu crashed, but
> decoding VMCS is not enough for that.

Interesting idea.  It should be possible if you attach all kvm state to
the core (and do quite a lot of digging to recover device model state).

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
