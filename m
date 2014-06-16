Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwePp-0000M2-9u
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 21:26:09 +0000
Message-ID: <539F60B3.1040509@zytor.com>
Date: Mon, 16 Jun 2014 14:25:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 07/13] kexec: Implementation of new syscall kexec_file_load
References: <20140606181859.GK1526@redhat.com>
 <20140609021122.GB1924@darkstar.nay.redhat.com>
 <20140609053538.GA2874@dhcp-17-89.nay.redhat.com>
 <20140609154137.GD22049@redhat.com> <20140613075011.GA4751@pd.tnic>
 <20140613124609.GC5871@redhat.com> <20140613153620.GG4751@pd.tnic>
 <20140616173823.GC4515@redhat.com> <20140616200526.GF8170@pd.tnic>
 <20140616205331.GA13257@redhat.com> <20140616210927.GJ8170@pd.tnic>
In-Reply-To: <20140616210927.GJ8170@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>, Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, jkosina@suse.cz, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On 06/16/2014 02:09 PM, Borislav Petkov wrote:
> 
> Nah, I don't feel strongly about it - I just don't trust userspace and
> think that every value we get from it should be "sanitized".
> 

Borislav and I talked about this briefly over IRC.  A key part of that
is that if userspace could manipulate this system call to consume an
unreasonable amount of memory, we would have a problem, for example if
this code used vzalloc() instead of kzalloc().  However, since
kmalloc/kzalloc implies a relatively restrictive limit on the memory
allocation size anyway, well short of anything that could cause OOM
problems, that pretty much solves the problem.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
