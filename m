Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNmv9-0004WL-DK
 for kexec@lists.infradead.org; Wed, 12 Mar 2014 17:26:23 +0000
Date: Wed, 12 Mar 2014 13:24:58 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 10/11] kexec: Support for loading ELF x86_64 images
Message-ID: <20140312172458.GK14981@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-11-git-send-email-vgoyal@redhat.com>
 <20140228145832.GF4326@pd.tnic> <20140228171142.GI28744@redhat.com>
 <20140307171233.GD5255@pd.tnic> <20140307183959.GE5255@pd.tnic>
 <20140310144237.GA4352@redhat.com> <20140312161919.GE23890@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140312161919.GE23890@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, greg@kroah.com

On Wed, Mar 12, 2014 at 05:19:19PM +0100, Borislav Petkov wrote:
> On Mon, Mar 10, 2014 at 10:42:37AM -0400, Vivek Goyal wrote:
> > When I posted V1 of patches, Eric Biederman had said that without ELF
> > loader support this patchset should not go in. He said that ELF is
> > very generic and if we are implementing a new system call we should
> > support ELF loader.
> 
> But why, if nobody uses it?

Eric, can you please help answer this one.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
