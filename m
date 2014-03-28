Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTXE3-0006IV-0Q
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 13:53:40 +0000
Date: Fri, 28 Mar 2014 09:53:13 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 4/4] x86: Pass memory range via E820 for kdump
Message-ID: <20140328135313.GD2089@redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-5-git-send-email-chaowang@redhat.com>
 <20140327225014.GR13816@redhat.com>
 <20140328045254.GB2944@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140328045254.GB2944@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, ebiederm@xmission.com

On Fri, Mar 28, 2014 at 12:52:54PM +0800, WANG Chao wrote:

[..]
> > > +static void add_setup_data(struct kexec_info *info,
> > > +			   struct x86_linux_param_header *real_mode,
> > > +			   struct setup_data *sd)
> > > +{
> > 
> > What is setup_data? A little comment above function will make it easy
> > to read. Is it that list of elements which contains extra memory map
> > entries?
> 
> Not exactly. All extra memory maps (for SETUP_E820_EXT type) are
> sealed into a single setup_data structure. Different types of setup_data
> are linked in a list.
> 
> setup_data can be used to pass extra data for boot, for example EFI
> data (SETUP_EFI), extended E820 map (SETUP_E820_EXT), SETUP_PCI and
> SETUP_DTB. These types are defined when defining struct setup_data.
> 
> It's offically documented in Documentation/x86/boot.txt.
> 
> Field name:	setup_data
> Type:		write (special)
> Offset/size:	0x250/8
> Protocol:	2.09+
> 
>   The 64-bit physical pointer to NULL terminated single linked list of
>   struct setup_data. This is used to define a more extensible boot
>   parameters passing mechanism. The definition of struct setup_data
>   is as follow:
> 
>   struct setup_data {
> 	  u64 next;
> 	  u32 type;
> 	  u32 len;
> 	  u8  data[0];
>   };
> 
>   Where, the next is a 64-bit physical pointer to the next node of
>   linked list, the next field of the last node is 0; the type is used
>   to identify the contents of data; the len is the length of data
>   field; the data holds the real payload.
> 
>   This list may be modified at a number of points during the bootup
>   process. Therefore, when modifying this list one should always make
>   sure to consider the case where the linked list already contains
>   entries.
> 
> I think I would comment add_setup_data as follows:
> 
> /*
>  * Added another instance to single linked list of struct setup_data.
>  * Please refer to kernel Documentation/x86/boot.txt for more details
>  * about setup_data structure.
>  */

Thanks for the explanation. Above comment will help the reader.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
