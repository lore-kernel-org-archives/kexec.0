Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI3zj-0000bz-EQ
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 21:22:57 +0000
Date: Tue, 19 Mar 2013 17:22:44 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 08/21] vmcore: copy non page-size aligned head and
 tail pages in 2nd kernel
Message-ID: <20130319212244.GE3872@redhat.com>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040132.15064.42257.stgit@localhost6.localdomain6>
 <878v5jqf5e.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878v5jqf5e.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

On Tue, Mar 19, 2013 at 01:59:57PM -0700, Eric W. Biederman wrote:
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
> 
> > Due to mmap() requirement, we need to copy pages not starting or
> > ending with page-size aligned address in 2nd kernel and to map them to
> > user-space.
> >
> > For example, see the map below:
> >
> >     00000000-00010000 : reserved
> >     00010000-0009f800 : System RAM
> >     0009f800-000a0000 : reserved
> >
> > where the System RAM ends with 0x9f800 that is not page-size
> > aligned. This map is divided into two parts:
> >
> >     00010000-0009f000
> >     0009f000-0009f800
> >
> > and the first one is kept in old memory and the 2nd one is copied into
> > buffer on 2nd kernel.
> >
> > This kind of non-page-size-aligned area can always occur since any
> > part of System RAM can be converted into reserved area at runtime.
> >
> > If not doing copying like this and if remapping non page-size aligned
> > pages on old memory directly, mmap() had to export memory which is not
> > dump target to user-space. In the above example this is reserved
> > 0x9f800-0xa0000.
> 
> So I have a question.  Would it not be easier to only support mmaping on
> the things that are easily mmapable?  And in the oddball corner cases
> require reading the data instead.

Hi Eric, 

Are you saying that some parts of the vmcore file will support mmap() and
others will not. If yes, how would a user know which parts of file are
mappable and which are not.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
