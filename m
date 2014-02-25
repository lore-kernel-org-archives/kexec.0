Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIPGR-0007Wf-Uv
 for kexec@lists.infradead.org; Tue, 25 Feb 2014 21:10:08 +0000
Message-ID: <530D068E.4040700@zytor.com>
Date: Tue, 25 Feb 2014 13:09:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 07/11] kexec: Create a relocatable object called purgatory
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-8-git-send-email-vgoyal@redhat.com>
 <530B989B.8010507@zytor.com> <20140225164342.GC2701@redhat.com>
 <530CCB0E.3060009@zytor.com> <20140225182002.GD2701@redhat.com>
In-Reply-To: <20140225182002.GD2701@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, greg@kroah.com

On 02/25/2014 10:20 AM, Vivek Goyal wrote:
> 
> Please let me know if you don't like the idea and you still think there
> should be a shared implementation between arch/x86/boot/ and
> arch/x86/purgatory/.
> 

That is what I would *prefer*.  There are some other string functions in
arch/x86/boot/string.c which also ought to be sharable (and are in
places already.)

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
